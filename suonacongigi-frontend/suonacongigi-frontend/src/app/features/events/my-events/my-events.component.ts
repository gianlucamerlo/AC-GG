import { Component, inject, OnInit, signal } from '@angular/core';
import { DatePipe } from '@angular/common';
import { RouterLink } from '@angular/router';
import { EventService } from '../../../core/services/event.service';
import { EventResponse } from '../../../core/models/event.model';
import { BaseComponent } from '../../../shared/base.component';
import { finalize } from 'rxjs';

@Component({
  selector: 'app-my-events',
  standalone: true,
  imports: [DatePipe, RouterLink],
  templateUrl: './my-events.component.html'
})
export class MyEventsComponent extends BaseComponent implements OnInit {
  private eventService = inject(EventService);

  events = signal<EventResponse[]>([]);
  actionLoading = signal<Record<number, boolean>>({});

  ngOnInit(): void {
    this.loadMyEvents();
  }

  loadMyEvents(): void {
    this.eventService.getMyEvents().subscribe({
      next: data => this.events.set(data ?? [])
    });
  }

  unregister(event: EventResponse): void {
    this.actionLoading.update(prev => ({ ...prev, [event.id]: true }));

    this.eventService.unregister(event.id).pipe(
      finalize(() => this.actionLoading.update(prev => ({ ...prev, [event.id]: false })))
    ).subscribe({
      next: () => {
        this.notifySuccess(`Disiscritto da: ${event.title}`);
        this.loadMyEvents();
      }
    });
  }
}